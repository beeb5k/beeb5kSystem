use std::any::type_name;

pub fn hello_world(action: &str) {
    // Every function in Rust has a unique, unnameable type.
    // we define a tiny helper to extract that type's name.
    fn get_type_name<T>(_: T) -> &'static str {
        type_name::<T>()
    }

    // This gives us "current_crate::hello_world"
    let full_path = get_type_name(hello_world);

    // We transform the string entirely through a lazy iterator pipeline.
    let formatted: String = full_path
        .split("::")
        .last()
        .unwrap_or("")
        .split('_')
        .map(|word| {
            // Capitalize the first letter and chain the rest
            let mut chars = word.chars();
            chars
                .next()
                .map(|f| f.to_uppercase().collect::<String>() + chars.as_str())
                .unwrap_or_default()
        })
        .collect::<Vec<_>>()
        .join(", ")
        + "!";

    println!("{}", formatted)
}

