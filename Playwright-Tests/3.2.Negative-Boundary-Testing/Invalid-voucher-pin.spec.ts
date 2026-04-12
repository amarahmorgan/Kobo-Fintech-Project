import { test, expect } from '@playwright/test';

test('Positive: Successful top-up using valid 16-digit Voucher PIN (R50)', async ({ page }) => {
  await page.goto('https://quality-engineering-labs.vercel.app/wallet.html');

  // Open Top Up Wallet modal
  await page.getByTestId('topup-btn').click();
  await expect(page.getByText('Top Up Wallet')).toBeVisible({ timeout: 15000 });

  // Enter amount R50
  await page.getByTestId('topup-amount').fill('50');

  // Select Voucher PIN method
  await page.locator('label').filter({ hasText: /^Voucher PIN$/ }).click();

  // Enter a valid 16-digit voucher PIN (using a dummy one as per your description)
  await page.getByTestId('topup-pin').fill('1234567812345678');

  // Click Process Top-Up
  await page.getByTestId('process-topup').click();

  // Expect the exact success message you mentioned
  await expect(page.getByText('Top-up successful! +R50 added via voucher')).toBeVisible({ 
    timeout: 10000 
  });

  // Optional: Also check for the green toast at the bottom
  await expect(page.getByText('Wallet topped up +R50')).toBeVisible({ timeout: 5000 }).catch(() => {});

  console.log('Voucher top-up with R50 was successful');
});