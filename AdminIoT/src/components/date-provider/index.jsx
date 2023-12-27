/* eslint-disable */

import * as React from 'react';
import vi from 'date-fns/locale/vi';
import { AdapterDateFns } from '@mui/x-date-pickers/AdapterDateFns';
import { LocalizationProvider } from '@mui/x-date-pickers/LocalizationProvider';


export default function LocalizationDateProvider({ children }) {
    return (
        <LocalizationProvider
            dateAdapter={AdapterDateFns}
            adapterLocale={vi}
        >
            {children}
        </LocalizationProvider>
    );
}
