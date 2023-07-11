import time
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By

# Launch Browser (local testing)
driver = webdriver.Chrome()
driver.maximize_window()

url = 'https://www.letour.fr/en/rankings'

driver.get(url)

time.sleep(3)
print('Checking for Current Stage...')
try:
    current_stage_ele = page_nav_link_back = driver.find_element(
        By.CLASS_NAME, 'stage-select__option__stage').text
    current_stage = current_stage_ele[current_stage_ele.rindex(
        ' ') + 1:]
    print('On current Stage: ' + current_stage)

    time.sleep(3)
    print('\nGetting General Rankings...')
    general_ranking_tab = driver.find_element(
        By.XPATH, '//span[@data-xtclick="ranking::tab::overall"]')
    general_ranking_tab.click()
    print('On General Rankings.\n')

    time.sleep(3)
    ranking_tabs = driver.find_elements(
        By.XPATH, '//span[@class="js-tabs-ranking-nested general"]')

    riders_data = []
    rider_data = {}

    for ranking_tab in ranking_tabs[:-2]:
        ranking_tab.click()
        ranking_tab_text = ranking_tab.text

        time.sleep(3)
        print('Getting ' + ranking_tab_text + ' rankings...')

        for rider in driver.find_elements(By.CLASS_NAME, 'rankingTables__row')[:10]:
            rider_rank = rider.find_element(
                By.CLASS_NAME, 'rankingTables__row__position').find_element(By.TAG_NAME, 'span').text
            rider_number = rider.find_element(
                By.CLASS_NAME, 'flag').get_attribute('data-bib')
            rider_country_ele = rider.find_element(
                By.CLASS_NAME, 'flag').get_attribute('data-class')
            rider_country = rider_country_ele[rider_country_ele.rindex(
                '-') + 1:].upper()
            rider_name = rider.find_element(
                By.CLASS_NAME, 'rankingTables__row__profile--name').text
            rider_team = rider.find_element(
                By.CSS_SELECTOR, '.break-line.team').find_element(By.TAG_NAME, 'a').text

            rider_data["rider_rank"] = rider_rank
            rider_data["rider_number"] = rider_number
            rider_data["rider_country"] = rider_country
            rider_data["rider_name"] = rider_name
            rider_data["rider_team"] = rider_team

            riders_data.append(rider_data)
            rider_data = {}

        print(riders_data)
        riders_data = []

except Exception as e:
    print(e)

driver.close()
driver.quit()

exit
