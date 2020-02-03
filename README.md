## HOW TO

### to build the .so libs
```
mkdir <build_dir>
cd <build_dir>
cmake -DLT_LLVM_INSTALL_DIR=<llvm_build_dir> ..
make
```

### to generate llvm IR code
```
clang  -emit-llvm -c input.c -o input.bc
```

### old and new pass manager
```
lpm: opt -load libHelloWorld.so -hello-world -disable-output <input-llvm-file>
npm: opt -load-pass-plugin=libHelloWorld.so -passes="hello-world" -disable-output <input-llvm-file>
```

## ultimate analyzer
```
./Ultimate -s config/svcomp-Termination-64bit-Automizer_Default.epf -tc config/AutomizerTermination.xml -i YOUR_C_FILE
```