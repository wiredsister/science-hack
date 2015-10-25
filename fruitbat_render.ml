open Nodejs


let () =
  let script = Dom_html.createScript Dom_html.document in
  script##.src := !$"client/vendor/trix.js";
  Dom.appendChild (Dom_html.document##.head) script;
  (* Firebug.console##log Dom_html.document *)
