import { test, expect } from '@playwright/test';

test('novy login', async ({ page }) => {
  await page.goto('http://testovani.kitner.cz/login');
  await page.getByTestId('email_input').click();
  await page.getByTestId('email_input').fill('riyofeh155@ippals.com');
  await page.getByTestId('password_input').click();
  await page.getByTestId('password_input').fill('tajnenovak');
  await page.getByTestId('login_button').click();

  await page.screenshot({ path: 'screenshot.png' });

  await expect(page.getByTestId('home_section')).toContainText('Vítej uživateli novak!');

  await page.getByTestId('logout_button').click();
});


