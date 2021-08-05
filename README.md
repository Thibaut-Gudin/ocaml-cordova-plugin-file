# ocaml-cordova-plugin-file

[![LGPL-v3 licensed](https://img.shields.io/badge/license-LGPLv3-blue.svg)](https://raw.githubusercontent.com/dannywillems/ocaml-cordova-plugin-file/master/LICENSE)
[![Build Status](https://travis-ci.org/dannywillems/ocaml-cordova-plugin-file.svg?branch=master)](https://travis-ci.org/dannywillems/ocaml-cordova-plugin-file)

Binding to
[cordova-plugin-file](https://github.com/apache/cordova-plugin-file)

[Example
application](https://github.com/dannywillems/ocaml-cordova-plugin-file-example).

## What does cordova-plugin-file do ?

```
This plugin implements a File API allowing read/write access to files residing
on the device.
```

Source: [cordova-plugin-file](https://github.com/apache/cordova-plugin-file)

## Repository branches and tags

We are migrating bindings from
[js_of_ocaml](https://github.com/ocsigen/js_of_ocaml) (low level bindings) to
[gen_js_api](https://github.com/lexifi/gen_js_api) (high level bindings).

The gen_js_api binding allows to use *pure* ocaml types (you don't have to use
the ## syntax from js_of_ocaml or Js.string type but only # and string type).

The js_of_ocaml version is available in the branch
[*js_of_ocaml*](https://github.com/dannywillems/ocaml-cordova-plugin-file/tree/js_of_ocaml)
but we **recommend** to use the gen_js_api version which is the master branch.

## How to install and compile your project by using this plugin ?

Don't forget to switch to a compiler **>= 4.03.0**.
```Shell
opam switch 4.03.0
```

You can use opam by pinning the repository with
```Shell
opam pin add cordova-plugin-file https://github.com/dannywillems/ocaml-cordova-plugin-file.git
```

and to compile your project, use
```Shell
ocamlfind ocamlc -c -o [output_file] -package gen_js_api -package cordova-plugin-file [...] -linkpkg [other arguments]
```

Don't forget to install the cordova plugin file with
```Shell
cordova plugin add cordova-plugin-file
```

## How to use ?

See the official documentation
[cordova-plugin-file](https://github.com/apache/cordova-plugin-file)

This plugin mainly contains string that you can see in the `.mli` file,
but it also contains other functions from `cordova.file`.

### `Cordova_file.resolve_local_file_system_url`

This function allows to convert URLs into a `DirectoryEntry`, but
beware, in this library it returns a `Js_of_ocaml.File.file
Js_of_ocaml.Js.t` value, in order to use the `Js_of_ocaml.File` plugin for the
callback management. You can learn more about this type in the
[Js_of_ocaml official
website](https://ocsigen.org/js_of_ocaml/3.1.0/api/File).

This function have 3 arguments: *url*, *successCallback* and
*errorCallback*. The first argument is pretty self-explanatory, but the
other two needs some secondary functions in order to be used properly.

The `File_entry` module is used for the `successCallback` of the
function: it contains functions that allows to access some value linked to
the argument of the callback like `file` that allow to use the value
returned but `resolve_local_file_system_url` into a function
automatically executed in the success case.

The `errorCallback` takes an argument of type `error`, you can for
example use the `Cordova_file.get_error_code` function to get a code and
indication of what caused the error. There are 12 differents *error code*
associated to this type:
           1 -> *Not Found Error*
           2 -> *Security Error*
           3 -> *Abort Error*
           4 -> *Not Readable Error*
           5 -> *Encoding Error*
           6 -> *No Modification Allowed Error*
           7 -> *Invalid State Error*
           8 -> *Syntax Error*
           9 -> *Invalid Modification Error*
           10 -> *Quota Exceeded Error*
           11 -> *Type Mismatch Error*
           12 -> *Path Exists Error*

### `Cordova_file._FileReader`
This function returns a new `fileReader` object form the
`Js_of_ocaml.File` plugin, you can learn more about this object
[here](https://ocsigen.org/js_of_ocaml/3.1.0/api/File.fileReader-c)

## TODO

* Allow to use methods which are available on the device depending on the
  operating system.
