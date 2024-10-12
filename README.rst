.. default-role:: code


###############################################
 Read Ansible documentation from within Neovim
###############################################

This plugin lets you open documentation as produced by `ansible-doc` right
within Neovim.


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


License
#######

Released under the MIT (Expat) license.  See the License_ file for details.
