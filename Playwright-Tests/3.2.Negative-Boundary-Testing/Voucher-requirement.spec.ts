import { test, expect } from '@playwright/test';

test('Negative: Top-up fails with invalid or short Voucher PIN', async ({ page }) => {
  await page.goto('https://quality-engineering-labs.vercel.app/wallet.html');

  await page.getByTestId('topup-btn').click();
  await expect(page.getByText('Top Up Wallet')).toBeVisible({ timeout: 15000 });

  await page.getByTestId('topup-amount').fill('100');
  await page.locator('label').filter({ hasText: /^Voucher PIN$/ }).click();

  // Test with short PIN
  await page.getByTestId('topup-pin').fill('1234');
  await page.getByTestId('process-topup').click();

  await expect(page.getByText('Enter a valid 16-digit voucher PIN')).toBeVisible({ timeout: 10000 });
});