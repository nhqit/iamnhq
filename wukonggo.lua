-- Khai báo ngôn ngữ mặc định (tiếng Việt)
local language = "vi"  -- "vi" cho tiếng Việt, "en" cho tiếng Anh

-- Các thông báo bằng tiếng Việt và Tiếng Anh (Thông báo chưa thay đổi)
local messages = {
    vi = {
        alert_wrong_app = "Vui lòng chọn đúng ứng dụng có tên Tây Du Go.",
        prompt_day = "Nhập giá trị Ngày:",
        prompt_chapter = "Nhập giá trị Chương:",
        prompt_new_day = "Nhập giá trị Ngày mới:",
        prompt_new_chapter = "Nhập giá trị Chương mới:",
        alert_invalid_value = "Lỗi: Giá trị không hợp lệ!",
        alert_edit_success = "Giá trị đã được chỉnh sửa thành công!",
        alert_no_results = "Không tìm thấy kết quả nào để chỉnh sửa.",
        alert_exit = "Đã thoát.",
        alert_language_changed = "Ngôn ngữ đã được thay đổi thành tiếng Anh.",
        alert_invalid_input = "Lỗi: Nhập sai giá trị!",
        menu_title = "Script by iamnhq:",
        option_1 = "Chỉnh sửa Ngày và Chương", 
        option_2 = "Hack Ngọc Tiên", 
        option_3 = "Thay đổi ngôn ngữ",
        option_4 = "Thoát",
        alert_enter_day_chapter = "Nhập giá trị Ngày và Chương để chỉnh sửa.",
        alert_hack_success = "Ngọc Tiên đã được hack thành công!"  
    },
    en = {
        alert_wrong_app = "Please choose the correct app Wukong Go.",
        prompt_day = "Enter the day value:",
        prompt_chapter = "Enter the chapter value:",
        prompt_new_day = "Enter the new day value:",
        prompt_new_chapter = "Enter the new chapter value:",
        alert_invalid_value = "Error: Invalid value!",
        alert_edit_success = "Values have been successfully edited!",
        alert_no_results = "No results found for editing.",
        alert_exit = "Exited.",
        alert_language_changed = "Language has been changed to English.",
        alert_invalid_input = "Error: Invalid input!",
        menu_title = "Script by iamnhq:",
        option_1 = "Edit day and chapter", 
        option_2 = "Hack Jade", 
        option_3 = "Change Language",
        option_4 = "Exit",
        alert_enter_day_chapter = "Enter the day and chapter values to edit.",
        alert_hack_success = "Jade has been hacked successfully!"  
    }
}

-- Kiểm tra đúng ứng dụng và package name
function checkApp()
    local appPackage = gg.getTargetPackage()  
    local expectedPackage = "wukong.journey.quest.adventure.games"  
    
    if appPackage ~= expectedPackage then
        gg.alert(messages[language].alert_wrong_app)  
        os.exit()  
    end
end

-- Hàm hiển thị menu chính
function showMenu()
    local choices = {
        messages[language].option_1, 
        messages[language].option_2,
        messages[language].option_3,
        messages[language].option_4
    }
    local choice = gg.choice(choices, nil, messages[language].menu_title)

    if choice == 1 then
        inputValues()
    elseif choice == 2 then
        hackNgocTien()
    elseif choice == 3 then
        changeLanguage()
    elseif choice == 4 then
        gg.alert(messages[language].alert_exit)
        os.exit()
    end
end

-- Hàm thay đổi ngôn ngữ
function changeLanguage()
    if language == "vi" then
        language = "en"
        gg.alert(messages[language].alert_language_changed)
    else
        language = "vi"
        gg.alert(messages[language].alert_language_changed)
    end

    showMenu()  -- Quay lại menu sau khi thay đổi ngôn ngữ
end

-- Hàm hack ngọc tiên
function hackNgocTien()
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("600;5700", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
    gg.refineNumber("5700", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
    
    revert = gg.getResults(500, nil, nil, nil, nil, nil, nil, nil, nil)
    
    gg.editAll("-2000000000", gg.TYPE_DWORD)

    gg.alert(messages[language].alert_hack_success)

    gg.clearResults()
    showMenu()
end

-- Hàm yêu cầu người dùng nhập giá trị 'Ngày' và 'Chương'
function inputValues()
    gg.alert(messages[language].alert_enter_day_chapter) 

    local day_input = gg.prompt({messages[language].prompt_day}, {"0"}, {"number"})
    local chapter_input = gg.prompt({messages[language].prompt_chapter}, {"0"}, {"number"})

    if day_input == nil or chapter_input == nil then
        gg.alert(messages[language].alert_invalid_value)
        return
    end

    local day = tonumber(day_input[1])
    local chapter = tonumber(chapter_input[1])

    if day == nil or chapter == nil then
        gg.alert(messages[language].alert_invalid_value)
        return
    end

    day = day * 2
    chapter = chapter * 2

    searchAndRefine(day, chapter)
end

-- Hàm tìm kiếm và lọc các giá trị trong bộ nhớ
function searchAndRefine(day, chapter)
    gg.setRanges(gg.REGION_ANONYMOUS)
    gg.searchNumber("537;"..day..";"..chapter..";3541;3513:25", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)

    gg.refineNumber(day..";"..chapter, gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)

    local results = gg.getResults(gg.getResultsCount())

    if #results == 0 then
        gg.alert(messages[language].alert_no_results)
        return
    end

    local values = gg.prompt({messages[language].prompt_new_day}, {"0"}, {"number"})
    if values == nil or values[1] == "" then
        gg.alert(messages[language].alert_invalid_value)
        return
    end

    local new_day = tonumber(values[1])
    if new_day == nil then
        gg.alert(messages[language].alert_invalid_value)
        return
    end
    new_day = new_day * 2

    local chapter_values = gg.prompt({messages[language].prompt_new_chapter}, {"0"}, {"number"})
    if chapter_values == nil or chapter_values[1] == "" then
        gg.alert(messages[language].alert_invalid_value)
        return
    end

    local new_chapter = tonumber(chapter_values[1])
    if new_chapter == nil then
        gg.alert(messages[language].alert_invalid_value)
        return
    end
    new_chapter = new_chapter * 2

    gg.editAll(new_day..";"..new_chapter, gg.TYPE_DWORD)

    gg.alert(messages[language].alert_edit_success)

    gg.clearResults()
end

-- Kiểm tra hết hạn
local expirationDate = {year = 2025, month = 2, day = 9}

function checkExpiration()
    local currentDate = os.date("*t")
    if currentDate.year > expirationDate.year or
       (currentDate.year == expirationDate.year and currentDate.month > expirationDate.month) or
       (currentDate.year == expirationDate.year and currentDate.month == expirationDate.month and currentDate.day > expirationDate.day) then
        gg.alert("Hạn sử dụng đã hết. Hãy liên hệ YTB: I'm NHQ.")
        os.exit()
    end
end

-- Kiểm tra hạn sử dụng và ứng dụng
checkExpiration()
checkApp()

-- Vòng lặp chính
while true do
    if gg.isVisible(true) then
        gg.setVisible(false)
        showMenu()
    end
end
