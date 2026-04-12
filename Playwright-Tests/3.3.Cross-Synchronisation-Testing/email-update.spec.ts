import { test, expect } from '@playwright/test';
 
test('Email address update', async ({ page }) => {
  await page.goto('https://quality-engineering-labs.vercel.app/login.html');
 
  await page.getByRole('textbox', { name: 'Username' }).fill('admin');
  await page.getByRole('textbox', { name: 'Password' }).fill('password123');
  await page.getByRole('button', { name: 'Sign In' }).click();
 
  await page.getByLabel('Main navigation').getByRole('link', { name: 'Settings' }).click();
  await page.getByTestId('set-email').click();
  await page.getByTestId('set-email').fill('Flashes.co@merchanthub.co.za');
  await page.getByTestId('save-profile').click();
 
  await expect(page.getByTestId('profile-saved')).toBeVisible();
  await expect(page.getByTestId('set-email')).toHaveValue('Flashes.co@merchanthub.co.za');
});
 
