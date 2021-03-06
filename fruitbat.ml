open Nodejs

let () =
  let app = Electron.App.require () in
  let main_window = ref Js.null in
  app##on
    !$"window-all-closed"
    !@begin fun () ->
        if (Js.to_string Nodejs.Process.process##.platform) <> "darwin"
        then app##quit ()
      end;
  app##on
    !$"ready"
    !@begin fun () ->

        main_window :=
          Js.Opt.return (new%js Electron.Browser_window.browser_window
                          (object%js val height = 800 val width = 600 end));

        let main_window_now =
          Js.Opt.get !main_window (fun () -> assert false)
        in

        main_window_now##loadUrl
          !$(Printf.sprintf "file://%s/index.html" (Nodejs_globals.__dirname ()));

        (* main_window_now##openDevTools (); *)

        main_window_now##on
          !$"closed"
          !@begin fun () ->
              main_window := Js.null
            end
      end
