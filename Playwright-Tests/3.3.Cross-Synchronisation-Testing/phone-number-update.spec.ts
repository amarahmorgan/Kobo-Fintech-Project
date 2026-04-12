import { test, expect } from '@playwright/test';

test('Cross-Role Sync: Admin updates Phone Number → Merchant sees change', async ({ browser }) => {
  const adminContext = await browser.newContext({ storageState: 'auth/admin-auth.json' });
  const merchantContext = await browser.newContext({ storageState: 'auth/merchant-auth.json' });

  const adminPage = await adminContext.newPage();
  const merchantPage = await merchantContext.newPage();

  console.log('Starting Cross-Role Phone Number Sync Test...');

  // Admin updates phone
  await adminPage.goto('https://quality-engineering-labs.vercel.app/settings.html');
  await adminPage.getByTestId('tab-profile').click();

  await adminPage.getByTestId('set-phone').clear();
  await adminPage.getByTestId('set-phone').fill('072 089 1234');
  await adminPage.getByTestId('save-profile').click();

  await expect(adminPage.getByTestId('profile-saved')).toBeVisible({ timeout: 10000 });
  console.log('Admin saved new phone: 072 089 1234');

  // Merchant checks
  await merchantPage.goto('https://quality-engineering-labs.vercel.app/settings.html');
  await merchantPage.getByTestId('tab-profile').click();

  const merchantPhone = await merchantPage.getByTestId('set-phone').inputValue();
  console.log(`Merchant currently sees phone: "${merchantPhone}"`);

  if (merchantPhone === '072 089 1234') {
    console.log('SUCCESS: Phone number synced across roles!');
  } else {
    console.log('FAILED: No sync detected. Merchant still has old value.');
  }

  await adminContext.close();
  await merchantContext.close();
});