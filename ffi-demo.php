<?php

$file='target/debug/libplay_once.dylib'; // the path of our dll
$ffi=FFI::cdef('const char* play_once(const char *pong);',$file);

var_dump($ffi->play_once("Jackie"));
