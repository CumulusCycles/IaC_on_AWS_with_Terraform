import time
import pandas as pd

from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service as ChromeService
from webdriver_manager.chrome import ChromeDriverManager

url = 'https://www.letour.fr/en/rankings'

# Headless Browser (Lambda)
# options = Options()
# options.add_argument("--headless=new")
# options.add_argument('window-size=1920x1080')
# driver = webdriver.Chrome(service=ChromeService(
#     ChromeDriverManager().install()), options=options)

# Launch Browser (local testing)
# driver = webdriver.Chrome(service=ChromeService(
#     ChromeDriverManager().install()))
# driver.maximize_window()

driver.get(url)

try:
    time.sleep(3)
    print('Checking for Current Stage...')
    no_ranking_indicator = driver.find_element(
        By.CSS_SELECTOR, '.noRanking.la').is_displayed()
    print('No Ranking Indicator displayed.')

    time.sleep(3)
    print('Clicking Page Nav Link Back to get to current Stage...')
    page_nav_link_back = driver.find_element(
        By.XPATH, '//a[@data-xtclick="pageRank::pageNav::Prev"]')
    page_nav_link_back.click()
except:
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

try:
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

        df = pd.DataFrame({'riders_data': riders_data})
        df.to_json('./data/' + ranking_tab_text.lower() + ".json")
        riders_data = []
except Exception as e:
    print('Error processing Rider data.')
    print(e)

print('\nComplete.')
time.sleep(3)
driver.close()
driver.quit()
