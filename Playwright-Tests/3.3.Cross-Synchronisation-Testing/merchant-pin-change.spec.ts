import { test, expect } from '@playwright/test';
 
test('Merchant pin change', async ({ page }) => {
  await page.goto('https://quality-engineering-labs.vercel.app/login.html');
  await page.getByTestId('login-username').click();
  await page.getByTestId('login-username').fill('admin');
  await page.getByTestId('login-password').click();
  await page.getByTestId('login-password').fill('password123');
  await page.getByTestId('login-submit').click();
  await page.getByLabel('Main navigation').getByRole('link', { name: 'Settings' }).click();
  await page.getByTestId('tab-security').click();
  await page.getByTestId('set-current-pin').click();
  await page.getByTestId('set-current-pin').fill('3771');
  await page.getByTestId('set-new-pin').click();
  await page.getByTestId('set-new-pin').fill('2771');
  await page.getByTestId('set-confirm-pin').click();
  await page.getByTestId('set-confirm-pin').fill('2771');
  await page.getByTestId('change-pin').click();
  await expect(page.getByTestId('pin-result')).toContainText('PIN changed successfully!');
});