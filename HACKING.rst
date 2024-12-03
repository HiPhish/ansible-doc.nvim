.. default-role:: code


#############################
 Hacking on ansible-doc.nvim
#############################


Inline syntax markers
#####################

In several places (probably any containing prose text) there can be inline
syntax markers like `C(some_var)`.  These are regular text in the JSON string,
so we have to parse the string for them.  The following markers exist:

- `M`: Module name, this is like a hyperlink
- `C`: Code
- `O`: Option
- `V`: Literal value
- `B`: Emphasis (bold)

We can manually add appropriate highlighting to a region using the API function
`nvim_buf_add_highlight({buffer},`.  Note that every marker has two opening
characters, the actual text, and one closing character.  We could replace
things like this:

- With the string in memory search for the pattern `[:upper:]\(([%)])+\)`, for
  each match keep track of its start (`s`) and length (`l`).
- Output the string
- Substitute the pattern for the first capture.
- Using the information from the first list apply highlighting.  For the i-th
  capture its start position is `c - i*3`, its length is `l-3`.

Alternatively use concealment to visually hide the markers.  Concealment has
the disadvantage that concealed characters still count towards the line length.

Another idea, using three steps:

- Add highlighting to pattern with marker, e.g. `\vC\(.+\)`
- Use substitution on the line to remove the closing parenthesis first:
  `s/\vC\(.+\zs\)`
- Use substitution on the line to remove the closing parenthesis second:
  `s/\vC\(`

Because we do not overwrite the entire string the highlighting remains
preserved.  As for hyperlinks, see `nvim_buf_set_extmark`.


JSON schema
###########

There is no official documentation of the schema, so this is my best effort.
The JSON produced is a 1:1 dump of the in-memory data Ansible is using, so by
reading the `get_man_text` of `cli/doc.py` we can get a reasonable idea of
which keys and values must exist in the JSON.


The data consists of a JSON object with entry per module.  The key is the fully
qualified name of the module, the value is the documentation.

.. code:: json

   {
     "ansible.builtin.command": {
     },
     "ansible.builtin.shell": {
     },
   }

Each of these module objects has a number of entries:

- `doc`
- `examples`
- `metadata`
- `return`

The `doc` entry
===============

`plugin_name`
   Name of the plugin, used in the first line

`filename`
   Name of the file where the plugin is defined, used in the first line

`description`
   Either a list of strings or a string.  Gets written down as TTY-ified text.

`version_added` (default `"historical"`)
   A string, optional.  Format as "version added"

`version_added` (default `"ansible-core"`)
   A string, optional.  Format as "version added"

`deprecated` (optional)
   A string or an object.  If a string output it as is.  If an object it must
   contain these keys:

   - `why`
   - `alternative`
   - `removed_in`
   - `version` (alias for `removed_in`, `removed_in` takes precedence)
   - `removed_at_date` (alternative to `removed_in`)

   The `why` and `alternative` are mandatory. If `removed_at_date` is given it
   takes precedence over `removed_in`.  Depending on which of the two is given
   the output string is slightly different:

   - `Will be removed in a release after %(removed_at_date)s`
   - `Will be removed in: Ansible %(removed_in)s`

`has_action` (optional)
   Boolean, used to insert some fixed text: This module has a corresponding
   action plugin.

`options`
   Object where the key is the name of the option, the value is the
   specification of the options.  Format this object as fields

`attributes` (Object, optional)
   The keys are names of the attributes, the values are specifications.  The
   specification is formatted as a YAML dump.

`notes` (List of strings, optional)
   Additional notes.  Formatted as a bullet list where each item is the
   TTY-ified version of the string.

`seealso` (List of objects, optional)
   Write a bullet point list, each item is the formatted form of one of the
   objects.  The exact output depends on the entries in the object.  There are
   four kinds:

   - Module (`module`, `description` optional)
   - Plugin (`plugin`, `plugin_type`, `description` optional)
   - Generic reference (`name`, `link`, `description`)
   - Reference to the Ansible documentation (`ref`, `description`)

   For modules and plugins the description is optional.  If it is missing and
   the module or plugin in built-in (`module` or `plugin` starts with
   `ansible.builtin.`) a default description is generated.  For each item we
   output the name, the description and a link.  The value of these three
   depend on the type of entry.

   Module
      The name is `Module module`.  The default description is `The official
      documentation on the {module} module.`.  The URL the URL to the online
      documentation of the module if the module is built-in, otherwise
      nothing.

   Plugin
      The name is `{plugin_type}{suffix} {plugin}` where `{suffix}` is `plugin`
      if `{plugin_type}` is neither `module` nor `role`.  The default
      description is `The official documentation on the {plugin}
      {plugin_type}{suffix}.`.  The URL the URL to the online documentation of
      the module if the module is built-in, otherwise nothing.

   Generic reference
      The name, description and link in that order.

   Reference
      The name (`ref`) and description in that order.  The URL is a URL to the
      Ansible documentation, that reference in particular.

`requirements` (List of strings, optional)
   Requirements, will be comma-concatenated and TTY-ified.

Generic handler
   This is a fallback for all other keys which do not fit. Each entry is
   printed as `{header}: {value}` where `{header}` is the appropriately
   indented and upper-cased key. How the value is printed depends on its type.
   A string is TTY-fied, a list is concatenated with commas, and everything
   else is YAML-dumped.

`plainexamples` or `examples` (String or object, optional)
   Examples; if string it is printed as is, if object the YAML dump is printed
   as is.

`returndocs` or `return` (optional)
   Object, describes the possible return values.  Formatted by as fields,
   similar to `options`.


Formatting fields
-----------------

This corresponds to the `add_fields` method.  It takes in an object where the
keys are the names of the fields and the values are specifications of the
fields as objects.  This function can be called recursively if the
specification itself contains fields as well.

The relevant keys are:

- `required` (boolean, optional, default false)
- `description` (string or list of strings, required)
- `options`, `suboptions`, `contains`, `spec` (all optional), these are
  suboptions
- `default` (optional)
- `env`, `ini`, `yaml`, `vars`, `keyword` (objects, all optional), config items
- `cli` (optional)
- `version_added`
- `version_added_collection`


TTY-ified text
--------------

This corresponds to the `tty_ify` method.  It applies various transformations
to the text, turning inline markup into ANSI escape codes or other characters.
In general most text is TTY-ified.


Notes on formatting
###################

Version added
=============

A version string tells us when something got added to Ansible; it consists of
the Ansible version number and the name of the collection.  If both are given
render it as something like `{version} of {collection}`, otherwise as
`version {version}`.
