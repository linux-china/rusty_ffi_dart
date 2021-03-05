use std::ffi::{CStr, CString};
use std::io::BufReader;
use std::os::raw::c_char;
use std::thread;
use std::time::Duration;

#[no_mangle]
pub extern "C" fn play_once(ptr: *const c_char) -> *const c_char {
    let name = unsafe { CStr::from_ptr(ptr).to_string_lossy().into_owned() };
    println!("{}", name);
    let result = format!("Hello {}", name);
    CString::new(result).unwrap().into_raw()
}

