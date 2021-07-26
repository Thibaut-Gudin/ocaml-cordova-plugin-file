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

module File_entry : sig
  type t

  val file : t -> (file -> unit) -> (error -> unit) -> unit [@@js.call]
end

val resolve_local_file_system_url :
  url:string ->
  successCallback:(File_entry.t -> unit) ->
  errorCallback:(error -> unit) ->
  file
  [@@js.global "window.resolveLocalFileSystemURL"]

[@@@js.stop]

type file_reader = Js_of_ocaml.File.fileReader Js_of_ocaml.Js.t

[@@@js.start]

[@@@js.implem type file_reader = Js_of_ocaml.File.fileReader Js_of_ocaml.Js.t]

[@@@js.implem let file_reader_of_js = Obj.magic]

val _FileReader : unit -> file_reader [@@js.new "FileReader"]
