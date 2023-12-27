import { Suspense } from 'react';
import ReactDOM from 'react-dom/client';
import { BrowserRouter } from 'react-router-dom';
import { HelmetProvider } from 'react-helmet-async';

import App from './app';
import { AuthProvider } from './hooks/Auth/auth';
import ToastProvider from './components/toast-container';
import LocalizationDateProvider from './components/date-provider';

// ----------------------------------------------------------------------

const root = ReactDOM.createRoot(document.getElementById('root'));

root.render(
  <HelmetProvider>
    <BrowserRouter>
      <Suspense>
        <AuthProvider>
          <ToastProvider>
            <LocalizationDateProvider>
              <App />
            </LocalizationDateProvider>
          </ToastProvider>
        </AuthProvider>
      </Suspense>
    </BrowserRouter>
  </HelmetProvider>
);
