use std::{fs, io};

use regex::Regex;
use walkdir::{DirEntry, WalkDir};

const HWMON_DIR: &str = "/sys/class/hwmon";

fn is_temp_input(entry: &DirEntry) -> bool {
    if let Some(name) = entry.file_name().to_str() {
        // name.contains()
        let re = Regex::new(r"temp(.+)_input").unwrap();
        return re.is_match(name);
    }
    false
}

fn main() -> io::Result<()> {
    for entry in WalkDir::new(HWMON_DIR)
        .follow_links(true)
        .max_depth(2)
        .into_iter()
        .filter_map(|r| r.ok())
        .filter(is_temp_input)
    {
        println!("{}", entry.path().display());
    }

    Ok(())
}
