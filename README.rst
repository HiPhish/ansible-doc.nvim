.. default-role:: code


###############################################
 Read Ansible documentation from within Neovim
###############################################

This plugin lets you open documentation as produced by `ansible-doc` right
within Neovim.

.. image:: https://github.com/user-attachments/assets/418dbfce-0182-4edf-8948-ccbeaa88ed28
   :alt: Screenshot of Neovim showing the documentation of an Ansible module


Installation
############

Install this like any other Neovim plugin.  You will need Ansible and more
specifically `ansible-doc` installed on your system


Configuration
#############

This is a no-config plugin, it works out of the box.


Usage
#####

The `:AnsibleDoc` command work similar to the `ansible-doc` CLI binary: you
give it the name of the module as the one and only argument.

.. code:: vim

   AnsibleDoc ansible.builtin.command


Status
######

It mostly works, but because there is no official JSON schema for the output of
`ansible-doc` there is a chance that I missed something.  Other than testing
there are a couple of things I would like to do before I call this plugin
finished:

- Handle inline links (`L(<text>,<url)`) in a reasonable way
- Proper formatting (with line breaks and stuff) and highlighting (as YAML) of
  sample values
- A library API (Lua and Vim script)
- Documentation covering the command, library and syntax groups that can be
  overridden


License
#######

Released under the MIT (Expat) license.  See the License_ file for details.
