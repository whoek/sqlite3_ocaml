module S = Sqlite3

(* string -> string -> string array list * string array *)
let  select ~dbf ~sql  =
  let db = S.db_open dbf in
  let data = ref []  in
  let head = ref [||] in
  let first_row = ref true in
  let cb row headers =
    if !first_row then begin
        data := [ row ];
        head := headers;
        first_row := false;
      end
    else begin
        data := !data @ [ row ];
      end;
  in
  let code = S.exec db ~cb sql in
  ( match code with
    | S.Rc.OK -> ()
    | r ->  prerr_endline (S.Rc.to_string r);
            prerr_endline (S.errmsg db)
  ) ;
  (!data, !head)


let create_table_sql =
  {|
   CREATE TABLE IF NOT EXISTS contacts (
   contact_id INTEGER PRIMARY KEY,
   first_name TEXT NOT NULL,
   last_name TEXT NOT NULL,
   email TEXT NOT NULL UNIQUE,
   phone TEXT NOT NULL UNIQUE
   );  |}

let db = S.db_open "test.db"

let () =
  match S.exec db create_table_sql with
  | S.Rc.OK -> print_endline "Ok"
  | r -> prerr_endline (S.Rc.to_string r); prerr_endline (S.errmsg db)

(* str option array list -> str *)
let csv_of_table r =
  let value v = Option.value v ~default:"" in
  let wrap s = "\"" ^ s ^ "\"" in
  let delim = "," in
  let tac s1 s2 = String.cat s2 s1 in
  r
  |> List.mapi (fun n x ->
           let line = (string_of_int @@ n + 1) ^ delim in
         Array.map (fun y -> wrap @@ value y) x
         |> Array.to_list
         |> String.concat delim
         |> String.cat line
       )
  |> String.concat "\n"
  |> tac "\n"


let () =

  let sql = Printf.sprintf {| select * from sap_issues;  |}  in
      (* data: string array list *)
      (* head: string array *)
  let dbf = "jira.db" in
  let data, _ = select ~dbf ~sql  in
  let xx = csv_of_table data in
  Printf.printf "%s\n"  xx
