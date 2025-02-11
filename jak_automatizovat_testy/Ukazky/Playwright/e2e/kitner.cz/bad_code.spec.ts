import { test, expect } from '@playwright/test';

test('test bad code', async ({ page }) => {
  await page.goto('https://kitner.cz/');
  await page.getByRole('link', { name: 'Moje nabídka' }).hover()
  await page.getByRole('link', { name: 'Tříměsíční kurz: Jak se stát testerem' }).click();
  await expect(page.getByText('Jak se stát testerem/testerkou')).toBeVisible();

  // chyby v kódu, nepatří tam 'page.
  await page.expect(page.getByTestId('status')).toContainText("Jak se stát testerem/testerkou")

  // tento kod se již neprovede i přesto, že je správně UI nezahlásí chybu
  await expect(page.locator('css=.nadpis-big')).toContainText("Jak se stát testerem/testerkou")
  await expect(page.locator('.nadpis-big')).toContainText("Jak se stát testerem/testerkou")

  await page.getByRole('heading', { name: 'Dopřejte si kurz „Jak se stát testerem/testerkou“ a staňte se špičkou v IT' }).click();



});