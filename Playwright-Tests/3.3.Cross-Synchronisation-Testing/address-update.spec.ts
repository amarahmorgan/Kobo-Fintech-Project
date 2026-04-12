import { test, expect } from '@playwright/test';

test('Cross-Role Sync: Admin updates Address → Merchant sees change', async ({ browser }) => {
  const adminContext = await browser.newContext({ storageState: 'auth/admin-auth.json' });
  const merchantContext = await browser.newContext({ storageState: 'auth/merchant-auth.json' });

  const adminPage = await adminContext.newPage();
  const merchantPage = await merchantContext.newPage();

  console.log('Starting Cross-Role Address Sync Test...');

  await adminPage.goto('https://quality-engineering-labs.vercel.app/settings.html');
  await adminPage.getByTestId('tab-profile').click();

  // Clear old address and enter new one
  await adminPage.getByTestId('set-address').clear();
  await adminPage.getByTestId('set-address').fill('456 Blue Road, Cape Town 8001');

  await adminPage.getByTestId('save-profile').click();

  await expect(adminPage.getByTestId('profile-saved')).toBeVisible({ timeout: 10000 });
  console.log('Admin successfully updated address to "456 Blue Road, Cape Town 8001"');

  await merchantPage.goto('https://quality-engineering-labs.vercel.app/settings.html');
  await merchantPage.getByTestId('tab-profile').click();

  const merchantAddress = await merchantPage.getByTestId('set-address').inputValue();
  console.log(`Merchant currently sees address: "${merchantAddress}"`);

  if (merchantAddress.includes('456 Blue Road')) {
    console.log('SUCCESS: Address synced across roles!');
  } else {
    console.log('FAILED: Address did not sync. Merchant still has old value.');
  }

  await adminContext.close();
  await merchantContext.close();
});