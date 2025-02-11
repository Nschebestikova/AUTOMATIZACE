import { test, expect } from '@playwright/test';
import { promises as fs } from 'fs';
import { promisify } from 'util';

const EMAIL_COUNTER_FILE = './email_counter.txt';
const readFile = promisify(fs.readFile);
const writeFile = promisify(fs.writeFile);

async function getEmailCounter(): Promise<number> {
    try {
        const data = await readFile(EMAIL_COUNTER_FILE, 'utf8');
        return parseInt(data);
    } catch (err) {
        // Pokud soubor neexistuje, vrátíme 0
        return 0;
    }
}

async function setEmailCounter(counter: number): Promise<void> {
    await writeFile(EMAIL_COUNTER_FILE, counter.toString());
}

async function generateEmail(): Promise<string> {
    const counter = await getEmailCounter();
    const newCounter = counter + 1;
    await setEmailCounter(newCounter);
    return `lucka+automatizace${newCounter}@example.com`;
}


test('registrace - již existující email', async ({ page }) => {
  await page.goto('http://testovani.kitner.cz/register');

  await page.getByTestId('name_input').fill('Joohny Tester')
  console.log("Ahoj");

  //generování emailu a zápis do pole email
  const email = await generateEmail();
  console.log(email); // This will log the generated email

  await page.getByTestId('email_input').fill(email)

  await page.getByTestId('password_input').fill('tajnenovak')
  //await page.getByTestId('password_again_input').fill('tajnenovak')

  await page.getByTestId('register_button').click()

  await expect(page.getByTestId('email_input_errors')).toContainText('The email has already been taken.')

  await page.screenshot(path="screenshot.png")

});