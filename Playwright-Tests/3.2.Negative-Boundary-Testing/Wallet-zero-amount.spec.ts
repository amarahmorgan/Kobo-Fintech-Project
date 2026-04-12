import { test, expect } from '@playwright/test';

test('Negative: Top-up fails with zero amount using EFT method', async ({ page }) => {
  await page.goto('https://quality-engineering-labs.vercel.app/wallet.html');

  await page.getByTestId('topup-btn').click();
  await expect(page.getByText('Top Up Wallet')).toBeVisible({ timeout: 15000 });

  await page.getByTestId('topup-amount').fill('0');
  await page.locator('label').filter({ hasText: 'EFT' }).click();

  await page.getByTestId('process-topup').click();

  await expect(page.getByText('Minimum top-up is R10')).toBeVisible({ timeout: 10000 });
});