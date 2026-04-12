import { test, expect } from '@playwright/test';

test('Cross-Role Sync: Admin clears transactions → Merchant sees empty state', async ({ browser }) => {
  const adminContext = await browser.newContext({ storageState: 'auth/admin-auth.json' });
  const merchantContext = await browser.newContext({ storageState: 'auth/merchant-auth.json' });

  const adminPage = await adminContext.newPage();
  const merchantPage = await merchantContext.newPage();

  console.log('Starting Clear Transactions Cross-Role Sync Test...');

  await adminPage.goto('https://quality-engineering-labs.vercel.app/settings.html');
  await adminPage.getByTestId('tab-data').click();

  // Click "Clear Transactions Only"
  await adminPage.getByRole('button', { name: 'Clear Transactions Only' }).click();

  // Handle the confirmation dialog
  await adminPage.once('dialog', dialog => {
    console.log(`Dialog: ${dialog.message()}`);
    dialog.accept();   // Click OK
  });

  // Wait for the second confirmation ("Transactions cleared.")
  await adminPage.once('dialog', dialog => {
    console.log(`Second Dialog: ${dialog.message()}`);
    dialog.accept();   // Click OK again
  });

  console.log('Admin cleared transactions');
 
  await merchantPage.goto('https://quality-engineering-labs.vercel.app/transactions.html');

  // Merchant should see the empty state message
  await expect(merchantPage.getByText('No transactions yet. Make a sale from the Products page or add one manually above.'))
    .toBeVisible({ timeout: 15000 });

  console.log('SUCCESS: Merchant sees empty transactions list after Admin cleared them');

  await adminContext.close();
  await merchantContext.close();
});

