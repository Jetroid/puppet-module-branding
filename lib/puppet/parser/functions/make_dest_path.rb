module Puppet::Parser::Functions
  newfunction(:make_dest_path) do |args|
    source_filepath = args[0]
    dest_dirpath = args[1]
    # Split to get filename.
    filename = source_filepath.split("/").last
    # If last character of destination_dirpath not a slash, then add one.
    dest_dirpath = dest_dirpath[-1,1] == "/" ? dest_dirpath : dest_dirpath + "/"
    #Append filename.
    return dest_dirpath + filename
  end
end
