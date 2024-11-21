const { chromium } = require('playwright');

(async () => {
  const browser = await chromium.launch({
    headless: false
  });
  const context = await browser.newContext();
  const page = await context.newPage();
  await page.goto('https://kitner.cz/');
  await page.getByRole('link', { name: 'Tříměsíční kurz: Jak se stát testerem' }).click();
  await page.getByRole('heading', { name: 'Dopřejte si kurz „Jak se stát testerem/testerkou“ a staňte se špičkou v IT' }).click({
    button: 'right'
  });
  await page.locator('#main').click();
  await page.getByRole('heading', { name: 'Dopřejte si kurz „Jak se stát testerem/testerkou“ a staňte se špičkou v IT' }).click();
  await page.locator('.activeSlide').click();
  await page.getByText('S lektorem a s kurzem celkově jsem byla moc spokojená. Lektor je klidný, trpěliv').click();
  await page.getByText('S lektorem a s kurzem celkově jsem byla moc spokojená. Lektor je klidný, trpěliv').click();

  // ---------------------
  await context.close();
  await browser.close();
})();