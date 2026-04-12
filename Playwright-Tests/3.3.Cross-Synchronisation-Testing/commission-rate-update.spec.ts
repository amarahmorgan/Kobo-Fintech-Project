import { test, expect } from '@playwright/test';
 
test('Commission rate update', async ({ page }) => {
  await page.goto('https://quality-engineering-labs.vercel.app/login.html');
  await page.getByTestId('login-username').click();
  await page.getByTestId('login-username').fill('admin');
  await page.getByTestId('login-password').click();
  await page.getByTestId('login-password').fill('password123');
  await page.getByTestId('login-submit').click();
  await page.getByLabel('Main navigation').getByRole('link', { name: 'Settings' }).click();
  await page.getByTestId('set-commission').click();
  await page.getByTestId('set-commission').fill('10');
  await page.getByTestId('save-profile').click();
  await expect(page.getByTestId('profile-saved')).toContainText('Settings saved!');
  await expect(page.getByTestId('set-commission')).toHaveValue('10');
});