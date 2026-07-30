function cr --description "Compile and run C file"
    gcc $argv[1] -o app
    and ./app
end
