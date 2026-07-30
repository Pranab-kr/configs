function rr --description "Compile and run Rust file"
    set file $argv[1]
    set bin (string replace -r '\.rs$' '' $file)

    rustc $file
    and ./$bin
end
