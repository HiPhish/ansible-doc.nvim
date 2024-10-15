.. default-role:: code


###############################################
 Read Ansible documentation from within Neovim
###############################################

This plugin lets you open documentation as produced by `ansible-doc` right
within Neovim.

.. image:: https://private-user-images.githubusercontent.com/4954650/376793104-418dbfce-0182-4edf-8948-ccbeaa88ed28.png?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3MjkwMjUwODIsIm5iZiI6MTcyOTAyNDc4MiwicGF0aCI6Ii80OTU0NjUwLzM3Njc5MzEwNC00MThkYmZjZS0wMTgyLTRlZGYtODk0OC1jY2JlYWE4OGVkMjgucG5nP1gtQW16LUFsZ29yaXRobT1BV1M0LUhNQUMtU0hBMjU2JlgtQW16LUNyZWRlbnRpYWw9QUtJQVZDT0RZTFNBNTNQUUs0WkElMkYyMDI0MTAxNSUyRnVzLWVhc3QtMSUyRnMzJTJGYXdzNF9yZXF1ZXN0JlgtQW16LURhdGU9MjAyNDEwMTVUMjAzOTQyWiZYLUFtei1FeHBpcmVzPTMwMCZYLUFtei1TaWduYXR1cmU9MmE3ZmFmMTM5MDRiOGRlNGY0NThhM2Q5ODY4ZTYwMDQ5ODFlM2Y1MDAxODA2NjBhYzNjMzg5MjVjNTJmZGU1NyZYLUFtei1TaWduZWRIZWFkZXJzPWhvc3QifQ.ByUGgdzmFGb4btvholhnN8dwQegoLp47Ucl9mpk4XrE
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


License
#######

Released under the MIT (Expat) license.  See the License_ file for details.
