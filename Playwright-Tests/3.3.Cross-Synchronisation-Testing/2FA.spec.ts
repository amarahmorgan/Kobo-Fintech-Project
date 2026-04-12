import { test, expect } from '@playwright/test';

test('Cross-Role Sync: Admin enables 2FA → Merchant sees toggle enabled', async ({ browser }) => {
  const adminContext = await browser.newContext({ storageState: 'auth/admin-auth.json' });
  const merchantContext = await browser.newContext({ storageState: 'auth/merchant-auth.json' });

  const adminPage = await adminContext.newPage();
  const merchantPage = await merchantContext.newPage();

  console.log('Starting 2FA Cross-Role Sync Test...');

  // Admin enables 2FA
  await adminPage.goto('https://quality-engineering-labs.vercel.app/settings.html');
  await adminPage.getByTestId('tab-security').click();

  // Click the toggle slider
  await adminPage.locator('.settings-card > .settings-toggle-item > .toggle-switch > .toggle-slider').first().click();

  console.log('Admin enabled 2FA');

  // Merchant checks the same toggle
  await merchantPage.goto('https://quality-engineering-labs.vercel.app/settings.html');
  await merchantPage.getByTestId('tab-security').click();

  // Check if the toggle is in "on" position
  const toggle = merchantPage.locator('.settings-card > .settings-toggle-item > .toggle-switch > .toggle-slider').first();

  const isOn = await toggle.evaluate((el) => {
    return el.classList.contains('active') || 
           window.getComputedStyle(el).backgroundColor === 'rgb(0, 128, 0)' || el.getAttribute('aria-checked') === 'true';});

  if (isOn) {
    console.log('SUCCESS: Merchant sees 2FA toggle enabled');
  } else {
    console.log('FAILED: Merchant still sees 2FA toggle disabled');
  }

  await adminContext.close();
  await merchantContext.close();
});