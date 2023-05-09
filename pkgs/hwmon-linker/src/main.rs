use std::{fs, io, os::unix::fs::symlink};

use clap::Parser;
use walkdir::{DirEntry, WalkDir};

const HWMON_DIR: &str = "/sys/class/hwmon";
const PATTERN_TEMP: &str = "temp";
const PATTERN_INPUT: &str = "_input";
const PATTERN_LABEL: &str = "_label";
const PATTERN_NAME: &str = "name";

#[derive(Parser, Debug)]
pub struct Args {
    /// The name of the hwmon path to use.
    #[arg(short, long)]
    name: String,

    /// The label of the hwmon path to use.
    #[arg(short, long)]
    label: String,

    /// The link to create for the specified hwmon path.
    #[arg(short = 'p', long)]
    link_path: String,
}

fn is_temp_input(entry: &DirEntry) -> bool {
    if let Some(name) = entry.file_name().to_str() {
        return name.contains(PATTERN_TEMP) && name.contains(PATTERN_INPUT);
    }
    false
}

fn main() -> io::Result<()> {
    let args = Args::parse();

    for temp_input in WalkDir::new(HWMON_DIR)
        .follow_links(true)
        .max_depth(2)
        .into_iter()
        .filter_map(|r| r.ok())
        .filter(is_temp_input)
    {
        let path = temp_input.path();
        if let Some(dir) = path.parent() {
            let name = fs::read_to_string(dir.join(PATTERN_NAME))?;
            if name.trim() != args.name {
                continue;
            }

            let path_str = path.to_str().unwrap();
            if let Some(index) = path_str.rfind(PATTERN_INPUT) {
                let mut label_path = path_str.to_string();
                label_path.replace_range(index.., PATTERN_LABEL);

                if let Ok(label) = fs::read_to_string(label_path) {
                    if label.trim() == args.label {
                        let _ = fs::remove_file(&args.link_path);
                        symlink(temp_input.path(), &args.link_path)?;
                    }
                }
            }
        }
    }

    Ok(())
}
