// Day04, Part01.
//
// Given a range, find how many different passwords would be within
// the range that meets the following criteria:
//  - 6-digit number
//  - value within range
//  - two adjacent numbers are the same
//  - Numbers from left to right are increasin
//    * 111123
//    * 135679
//
// My puzzle input is: 137683-596253
fn main() {
    let mut valid_passwords: i32 = 0;
    for n in 137683..596253 {
        let digits: Vec<u32> = get_num_digits(n);
        if is_valid_password(digits) {
            valid_passwords += 1;
        }
    }

    println!("{} valid_passwords", valid_passwords);
}

fn get_num_digits(n: i32) -> Vec<u32> {
    n.to_string()
        .chars()
        .map(|c| c.to_digit(10).unwrap())
        .collect()
}

fn is_valid_password(digits: Vec<u32>) -> bool {
    let mut repeat_numbers: i32 = 0;
    let mut digit_iter = digits.iter().peekable();
    while let Some(cur) = digit_iter.next() {
        if let Some(next) = digit_iter.peek() {
            if cur > next {
                return false;
            } else if cur == *next {
                repeat_numbers += 1;
            }
        }
    }
    if repeat_numbers > 0 {
        return true;
    }
    return false;
}
