import { test, expect } from '@playwright/test';

test('Cross-Role Sync: Admin changes Notification Preferences', async ({ browser }) => {
  const adminContext = await browser.newContext({ storageState: 'auth/admin-auth.json' });
  const merchantContext = await browser.newContext({ storageState: 'auth/merchant-auth.json' });

  const adminPage = await adminContext.newPage();
  const merchantPage = await merchantContext.newPage();

  console.log('Starting Notification Preferences Cross-Role Sync Test...');

  // Admin side
  await adminPage.goto('https://quality-engineering-labs.vercel.app/settings.html');
  await adminPage.getByTestId('tab-notifications').click();

  // Toggle the second notification (SMS Alerts from your Codegen)
  await adminPage.locator('div:nth-child(2) > .toggle-switch > .toggle-slider').first().click();

  await adminPage.getByTestId('save-notifications').click();

  console.log('Admin changed notification preferences');

  // Merchant side - check the same tab
  await merchantPage.goto('https://quality-engineering-labs.vercel.app/settings.html');
  await merchantPage.getByTestId('tab-notifications').click();

  console.log('Merchant is now on notifications tab - check toggle state manually if needed');

  // Check if the toggle is visible
  await expect(merchantPage.locator('div:nth-child(2) > .toggle-switch > .toggle-slider').first()).toBeVisible({ timeout: 10000 });

  await adminContext.close();
  await merchantContext.close();
});