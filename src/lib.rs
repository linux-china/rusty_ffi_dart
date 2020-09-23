use std::ffi::{CStr, CString};
use std::io::BufReader;
use std::os::raw::c_char;
use std::thread;
use std::time::Duration;

#[no_mangle]
pub extern "C" fn play_once(ptr: *const c_char) -> *const c_char {
    let name = unsafe { CStr::from_ptr(ptr).to_string_lossy().into_owned() };
    //play_music(&name);
    println!("{}", name);
    let result = format!("Hello {}", name);
    CString::new(result).unwrap().into_raw()
}

#[allow(dead_code)]
fn play_music(name: &str) {
    let device = rodio::default_output_device().unwrap(); // instantiate radio with the default speaker
    let file = std::fs::File::open(name).unwrap(); // open file
    let beep1 = rodio::play_once(&device, BufReader::new(file)).unwrap(); // play audio
    beep1.set_volume(0.2); //set volume (automatically set to 0 on mac apparently)
    println!("Start to play music");
    thread::sleep(Duration::from_secs(10)); // wait 10 s until stop playing
    drop(beep1); // drop reference to beep1
    println!("End to play music");
}
