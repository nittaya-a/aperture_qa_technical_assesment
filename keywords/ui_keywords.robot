*** Keywords ***

Remove Test Result Screenshots File In Test Case ID Folder
    ${test_case_id}    Get From List    ${TEST TAGS}    2
    ${test_case_folder_exists}    Run Keyword and Return Status    Directory Should Exist    ${EXECDIR}/test_result/ui/screenshots/${test_case_id}
    IF  ${test_case_folder_exists} == ${True}
        Empty Directory    ${EXECDIR}/test_result/ui/screenshots/${test_case_id}
    END
    
Create Test Case ID Folder
    ${test_case_id}    Get From List    ${TEST TAGS}    2
    ${test_case_folder_exists}    Run Keyword and Return Status    Directory Should Exist    ${EXECDIR}/test_result/ui/screenshots/${test_case_id}
    IF  ${test_case_folder_exists} == ${False}
        Create Directory    ${EXECDIR}/test_result/ui/screenshots/${test_case_id}
    END
    Set Test Variable    ${test_case_id}    ${test_case_id}

Capture Page Screenshot In Case Fail On Website
    ${test_case_id}                            Get From List    ${TEST TAGS}    2
    Create Directory                           ${EXECDIR}/test_result/ui/screenshots/${test_case_id}
    SeleniumLibrary.Capture Page Screenshot    filename=${EXECDIR}/test_result/ui/screenshots/${test_case_id}/Fail/fail.png

Open A Web Browser And Navigate To Source Demo URL
    [Arguments]    ${url}    ${browser}    ${step}=${NONE}
    SeleniumLibrary.Open Browser    url=${url}    browser=${browser}
    SeleniumLibrary.Maximize Browser Window
    IF  '${step}' != '${NONE}'
        SeleniumLibrary.Capture Page Screenshot 	 filename=${EXECDIR}/test_result/ui/screenshots/${test_case_id}/${step} Open A Web Browser And Navigate To Source Demo URL.png
    END

Log In A Source Demo Website
    [Arguments]    ${username}    ${password}    ${step}=${NONE}
    SeleniumLibrary.Wait Until Page Contains Element    ${log_in_page_user_name_field}
    SeleniumLibrary.Input Text    ${log_in_page_user_name_field}        ${username}
    SeleniumLibrary.Input Text    ${log_in_page_user_password_field}    ${password}
    IF  '${step}' != '${NONE}'
        SeleniumLibrary.Capture Page Screenshot 	 filename=${EXECDIR}/test_result/ui/screenshots/${test_case_id}/${step} Log In A Source Demo Website.png
    END
    SeleniumLibrary.Click Element 	 ${log_in_page_log_in_button}

Add Products To The Cart
    [Arguments]    ${products}    ${step}=${NONE}
    ${total_product}    Get Length    ${products}
    FOR  ${index}  IN RANGE  0  ${total_product}
        SeleniumLibrary.Wait Until Page Contains Element 	 xpath://div[text()='${products}[${index}][product_name]']/../../../div[@class='pricebar']//button[text()='Add to cart']
        SeleniumLibrary.Click Element 	                     xpath://div[text()='${products}[${index}][product_name]']/../../../div[@class='pricebar']//button[text()='Add to cart']
    END
    IF  '${step}' != '${NONE}'
        SeleniumLibrary.Capture Page Screenshot 	 filename=${EXECDIR}/test_result/ui/screenshots/${test_case_id}/${step} Add Products To The Cart.png
    END

Click Cart Button On The Top Right Of The Screen
    [Arguments]    ${step}=${NONE}
    SeleniumLibrary.Wait Until Page Contains Element    ${products_page_shopping_cart_button}
    SeleniumLibrary.Click Element 	                    ${products_page_shopping_cart_button}
    IF  '${step}' != '${NONE}'
        SeleniumLibrary.Capture Page Screenshot 	 filename=${EXECDIR}/test_result/ui/screenshots/${test_case_id}/${step} Click Cart Button On The Top Right Of The Screen.png
    END

Click Checkout Button
    [Arguments]    ${step}=${NONE}
    SeleniumLibrary.Wait Until Page Contains Element    ${cart_page_checkout_button}
    SeleniumLibrary.Click Element 	                    ${cart_page_checkout_button}
    IF  '${step}' != '${NONE}'
        SeleniumLibrary.Capture Page Screenshot 	 filename=${EXECDIR}/test_result/ui/screenshots/${test_case_id}/${step} Click Checkout Button.png
    END

Input Your Information On Checkout Step 1 Page
    [Arguments]    ${first_name}=${NONE}    ${last_name}=${NONE}    ${postal_code}=${NONE}    ${step}=${NONE}
    IF  '${first_name}' != '${NONE}'
        SeleniumLibrary.Wait Until Page Contains Element    ${checkout_step_1_page_first_name_field}
        SeleniumLibrary.Input Text                          ${checkout_step_1_page_first_name_field}    ${first_name}
    END
    IF  '${last_name}' != '${NONE}'
        SeleniumLibrary.Wait Until Page Contains Element    ${checkout_step_1_page_last_name_field}
        SeleniumLibrary.Input Text                          ${checkout_step_1_page_last_name_field}    ${last_name}
    END
    IF  '${postal_code}' != '${NONE}'
        SeleniumLibrary.Wait Until Page Contains Element    ${checkout_step_1_page_postal_code_field}
        SeleniumLibrary.Input Text                          ${checkout_step_1_page_postal_code_field}    ${postal_code}
    END
    IF  '${step}' != '${NONE}'
        SeleniumLibrary.Capture Page Screenshot 	 filename=${EXECDIR}/test_result/ui/screenshots/${test_case_id}/${step} Input Your Information On Checkout Step 1 Page.png
    END

Click Continue Button
    [Arguments]    ${step}=${NONE}
    SeleniumLibrary.Wait Until Page Contains Element    ${checkout_step_1_page_continue_button}
    SeleniumLibrary.Click Element 	                    ${checkout_step_1_page_continue_button}
    IF  '${step}' != '${NONE}'
        SeleniumLibrary.Capture Page Screenshot 	 filename=${EXECDIR}/test_result/ui/screenshots/${test_case_id}/${step} Click Continue Button.png
    END

Validate The Items, Price, And Quantity On The Cart Page
    [Arguments]    ${expected_selected_items}    ${step}=${NONE}
    ${total_item}    Get Length    ${expected_selected_items}
    FOR  ${index}  IN RANGE  0  ${total_item}
        SeleniumLibrary.Wait Until Page Contains Element 	 xpath://div[text()='${expected_selected_items}[${index}][product_name]']
        SeleniumLibrary.Page Should Contain Element 	     xpath://div[text()='${expected_selected_items}[${index}][product_name]']
        SeleniumLibrary.Page Should Contain Element 	     xpath://div[text()='${expected_selected_items}[${index}][product_name]']/../../..//div[text()='${expected_selected_items}[${index}][quantity]']
        ${actual_price}                                      SeleniumLibrary.Get Text    //div[text()='${expected_selected_items}[${index}][product_name]']/../..//div[@class='inventory_item_price']
        Should Be Equal                                      $${expected_selected_items}[${index}][price]    ${actual_price}
    END
    IF  '${step}' != '${NONE}'
        SeleniumLibrary.Capture Page Screenshot 	 filename=${EXECDIR}/test_result/ui/screenshots/${test_case_id}/${step} Validate The Items, Price, And Quantity On The Cart Page.png
    END

Validate The Items, Price, Quantity, Total, And Total With Tax
    [Arguments]    ${expected_selected_items}    ${step}=${NONE}
    ${total_item}    Get Length    ${expected_selected_items}
    ${total_without_tax}    Set Variable    ${0}
    FOR  ${index}  IN RANGE  0  ${total_item}
        SeleniumLibrary.Wait Until Page Contains Element 	 xpath://div[text()='${expected_selected_items}[${index}][product_name]']
        SeleniumLibrary.Page Should Contain Element 	     xpath://div[text()='${expected_selected_items}[${index}][product_name]']
        SeleniumLibrary.Page Should Contain Element 	     xpath://div[text()='${expected_selected_items}[${index}][product_name]']/../../..//div[text()='${expected_selected_items}[${index}][quantity]']
        ${actual_price}                                      SeleniumLibrary.Get Text    //div[text()='${expected_selected_items}[${index}][product_name]']/../..//div[@class='inventory_item_price']
        Should Be Equal                                      $${expected_selected_items}[${index}][price]    ${actual_price}
        # Validate total
        ${item_price}           Evaluate    ${expected_selected_items}[${index}][price] * ${expected_selected_items}[${index}][quantity]
        # Log To Console          \n${item_price}
        ${total_without_tax}    Evaluate    ${total_without_tax} + ${item_price}
        # Log To Console          \n${total_without_tax}
    END
    ${actual_item_total}        SeleniumLibrary.Get Text    ${checkout_step_2_page_item_total_text}
    # Log To Console              \n${actual_item_total}
    Should Be Equal             ${actual_item_total}    Item total: $${total_without_tax}
    ${tax}                      SeleniumLibrary.Get Text    ${checkout_step_2_page_tax_text}
    ${tax}                      Replace String    ${tax}    Tax: $    ${EMPTY}
    # Log To Console              \n${tax}
    ${total_with_tax}           Evaluate    ${total_without_tax} + ${tax}
    ${total_with_tax}           Convert To Number    ${total_with_tax}    2
    # Log To Console              \n${total_with_tax}
    ${actual_total_with_tax}    SeleniumLibrary.Get Text    ${checkout_step_2_page_total_with_tax_text}
    # Log To Console              \n${actual_total_with_tax}
    Should Be Equal             ${actual_total_with_tax}    Total: $${total_with_tax}
    IF  '${step}' != '${NONE}'
        SeleniumLibrary.Capture Page Screenshot 	 filename=${EXECDIR}/test_result/ui/screenshots/${test_case_id}/${step} Validate The Items, Price, Quantity, Total, And Total With Tax.png
    END

Click Finish Button
    [Arguments]    ${step}=${NONE}
    SeleniumLibrary.Scroll Element Into View 	        ${checkout_step_2_page_finish_button}
    SeleniumLibrary.Wait Until Page Contains Element    ${checkout_step_2_page_finish_button}
    IF  '${step}' != '${NONE}'
        SeleniumLibrary.Capture Page Screenshot 	 filename=${EXECDIR}/test_result/ui/screenshots/${test_case_id}/${step} Click Finish Button.png
    END
    SeleniumLibrary.Click Element 	                    ${checkout_step_2_page_finish_button}

Validate The Checkout Successful Message
    [Arguments]    ${step}=${NONE}
    SeleniumLibrary.Wait Until Page Contains Element    ${checkout_complete_page_checkout_complete_title}
    SeleniumLibrary.Page Should Contain Element         ${checkout_complete_page_checkout_complete_title}
    SeleniumLibrary.Page Should Contain Element         ${checkout_complete_page_thank_you_for_your_order_message}
    IF  '${step}' != '${NONE}'
        SeleniumLibrary.Capture Page Screenshot 	 filename=${EXECDIR}/test_result/ui/screenshots/${test_case_id}/${step} Validate The Checkout Successful Message.png
    END

Validate The Error Message
    [Arguments]    ${error_message_locator}    ${step}=${NONE}
    SeleniumLibrary.Wait Until Page Contains Element    ${error_message_locator}
    SeleniumLibrary.Page Should Contain Element         ${error_message_locator}
    IF  '${step}' != '${NONE}'
        SeleniumLibrary.Capture Page Screenshot 	 filename=${EXECDIR}/test_result/ui/screenshots/${test_case_id}/${step} Validate The Error Message.png
    END