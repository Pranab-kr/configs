function cpr --description "Compile and run C++ file"
    g++ $argv[1] -o app
    and ./app
end
