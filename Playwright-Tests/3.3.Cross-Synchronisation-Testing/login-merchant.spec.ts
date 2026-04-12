import { test , expect } from '@playwright/test';

test('Create Admin and Merchant auth states', async ({ page }) => {
  
  await page.goto('https://quality-engineering-labs.vercel.app/login.html');

  await page.getByTestId('login-username').fill('admin');
  await page.getByTestId('login-password').fill('password123');
  await page.getByRole('button', { name: 'Sign In' }).click();

  await expect(page.getByText('Welcome back, Admin')).toBeVisible({ timeout: 20000 });

  // Save as Admin
  await page.context().storageState({ path: 'auth/admin-auth.json' });
  console.log('admin-auth.json saved');

  // same session as Merchant (for testing purposes)
  await page.context().storageState({ path: 'auth/merchant-auth.json' });
  console.log('merchant-auth.json saved (using same admin session)');

});