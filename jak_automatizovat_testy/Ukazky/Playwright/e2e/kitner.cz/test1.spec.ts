import { test, expect } from '@playwright/test';

test('test kitner.cz', async ({ page }) => {
  await page.goto('https://kitner.cz/');
  await page.getByRole('link', { name: 'Moje nabídka' }).hover()
  await page.getByRole('link', { name: 'Tříměsíční kurz: Jak se stát testerem' }).click();
  await expect(page.getByText('Jak se stát testerem/testerkou')).toBeVisible();

  await expect(page.locator('css=.nadpis-big')).toContainText("Jak se stát testerem/testerkou")
  await expect(page.locator('.nadpis-big')).toContainText("Jak se stát testerem/testerkou")

  await page.getByRole('heading', { name: 'Dopřejte si kurz „Jak se stát testerem/testerkou“ a staňte se špičkou v IT' }).click();

});



