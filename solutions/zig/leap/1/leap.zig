pub fn isLeapYear(year: u32) bool {
    if (year % 100 == 0) {
        return year % 400 == 0;
    }

    return year % 4 == 0;
}
