(* -------------------------------------------------------------------------- *)
(* !! Read the documentation to know which directory are available on your
 * plateform !!
 *)
val application_directory : unit -> string
  [@@js.get "cordova.file.applicationDirectory"]

val application_storage_directory : unit -> string
  [@@js.get "cordova.file.applicationStorageDirectory"]

val data_directory : unit -> string [@@js.get "cordova.file.dataDirectory"]

val cache_directory : unit -> string [@@js.get "cordova.file.cacheDirectory"]

val external_application_storage_directory : unit -> string
  [@@js.get "cordova.file.externalApplicationStorageDirectory"]

val external_data_directory : unit -> string
  [@@js.get "cordova.file.externalDataDirectory"]

val external_cache_directory : unit -> string
  [@@js.get "cordova.file.externalCacheDirectory"]

val external_root_directory : unit -> string
  [@@js.get "cordova.file.externalRootDirectory"]

val temp_directory : unit -> string [@@js.get "cordova.file.tempDirectory"]

val synced_data_directory : unit -> string
  [@@js.get "cordova.file.syncedDataDirectory"]

val documents_directory : unit -> string
  [@@js.get "cordova.file.documentsDirectory"]

val shared_directory : unit -> string [@@js.get "cordova.file.sharedDirectory"]

(* -------------------------------------------------------------------------- *)

(*Functions associated with cordova-plugin-file*)

[@@@js.stop]

type error = Js_of_ocaml.File.fileError

type file = Js_of_ocaml.File.file Js_of_ocaml.Js.t

[@@@js.start]

[@@@js.implem type file = Js_of_ocaml.File.file Js_of_ocaml.Js.t]

[@@@js.implem type error = Js_of_ocaml.File.fileError]

[@@@js.implem let file_of_js = Obj.magic]

[@@@js.implem let error_of_js = Obj.magic]

[@@@js.implem let error_to_js = Obj.magic]

val get_error_code : error -> int [@@js.get "code"]

[@@@js.stop]

val get_error_code_exn : error -> exn

[@@@js.start]

[@@@js.implem
let get_error_code_exn e =
  let code = get_error_code e in
  match code with
  | 1 -> Not_found
  | 2 -> Failure "Security Error"
  | 3 -> Failure "Abort Error"
  | 4 -> Invalid_argument "Not Readable Error"
  | 5 -> Invalid_argument "Encoding Error"
  | 6 -> Failure "No Modification Allowed Error"
  | 7 -> Failure "Invalid State Error"
  | 8 -> Invalid_argument "Syntaxe Error"
  | 9 -> Failure "Invalid Modification Error"
  | 10 -> Failure "Quota Exceeded Error"
  | 11 -> Failure "Typing Mismatch Error"
  | 12 -> Failure "Path Exists Error"
  (*Their is only 12 ""ode Error"" known*)
  | _ -> Match_failure ("cordova_file.mli", 70, 2)]

type flags

val flags : ?create:bool -> ?exclusive:bool -> unit -> flags
  [@@js.builder] [@@js.verbatim_names]

module File_writer : sig
  type t

  val write : t -> string -> unit [@@js.call]

  val set_onwriteend : t -> (unit -> unit) -> unit [@@js.set]

  val set_onerror : t -> (error -> unit) -> unit [@@js.set]
end

module File_entry : sig
  type t

  val to_url : t -> string [@@js.get "toURL"]

  val create_writer :
    t ->
    successCallback:(File_writer.t -> unit) ->
    ?errorCallback:(error -> unit) ->
    unit ->
    unit
    [@@js.call]

  val file :
    t ->
    successCallback:(file -> unit) ->
    ?errorCallback:(error -> unit) ->
    unit ->
    unit
    [@@js.call]

  (*TODO find if a single definition is possible*)
  val resolve_local_file_system_url :
    url:string ->
    successCallback:(t -> unit) ->
    ?errorCallback:(error -> unit) ->
    unit ->
    file
    [@@js.global "window.resolveLocalFileSystemURL"]
end

module Directory_entry : sig
  type t

  val get_file :
    t ->
    path:string ->
    ?options:flags ->
    ?successCallback:(File_entry.t -> unit) ->
    ?errorCallback:(error -> unit) ->
    unit ->
    unit
    [@@js.call]

  val get_directory :
    t ->
    path:string ->
    ?options:flags ->
    ?successCallback:(t -> unit) ->
    ?errorCallback:(error -> unit) ->
    unit ->
    unit
    [@@js.call]

  (*TODO find if a single definition is possible*)
  val resolve_local_file_system_url :
    url:string ->
    successCallback:(t -> unit) ->
    ?errorCallback:(error -> unit) ->
    unit ->
    file
    [@@js.global "window.resolveLocalFileSystemURL"]
end

(*
TODO: is it possible to put all the `entry` into a single type?
I tried to create a common type that allow to use the entry that we prefer in success callbacks
with for exeample "DirectoryEntry entry" or "FileEntry entry" for then use `entry` to call the functions we like.
But it never worked, if you can fixup it feel free do to it and then remove my multiple definition of resolve_local_file_system_url
*)

(*
[@@@js.stop]

type entry

val file_entry : File_entry.t -> entry

val directory_entry : Directory_entry.t -> entry

[@@@js.start]

[@@@js.implem
type entry = DirectoryEntry of Directory_entry.t | FileEntry of File_entry.t

let file_entry x = FileEntry x

let directory_entry x = DirectoryEntry x]

[@@@js.implem let entry_of_js = Obj.magic]
 *)

(*
type entry =
  | DirectoryEntry of Directory_entry.t [@js.default]
  | FileEntry of File_entry.t [@js.default]
[@@js.sum "kind"]
      *)

(*TODO find who to have only 1 call of this function for every type of `entry` if possible ...*)
(*
val resolve_local_file_system_url :
  url:string ->
  successCallback:(entry -> unit) ->
  ?errorCallback:(error -> unit) ->
  unit ->
  file
  [@@js.global "window.resolveLocalFileSystemURL"]
 *)

[@@@js.stop]

type file_reader = Js_of_ocaml.File.fileReader Js_of_ocaml.Js.t

[@@@js.start]

[@@@js.implem type file_reader = Js_of_ocaml.File.fileReader Js_of_ocaml.Js.t]

[@@@js.implem let file_reader_of_js = Obj.magic]

val _FileReader : unit -> file_reader [@@js.new "FileReader"]
