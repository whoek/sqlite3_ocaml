open Sqlite3

let create_table_sql =
  {|
   CREATE TABLE IF NOT EXISTS contacts (
   contact_id INTEGER PRIMARY KEY,
   first_name TEXT NOT NULL,
   last_name TEXT NOT NULL,
   email TEXT NOT NULL UNIQUE,
   phone TEXT NOT NULL UNIQUE
   );  |}

let db = db_open "test.db"

let () =
  match exec db create_table_sql with
  | Rc.OK -> print_endline "Ok"
  | r -> prerr_endline (Rc.to_string r); prerr_endline (errmsg db)
