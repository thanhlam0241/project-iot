/* eslint-disable */

import * as React from 'react';
import de from 'date-fns/locale/de';
import enGB from 'date-fns/locale/en-GB';
import zhCN from 'date-fns/locale/zh-CN';
import { AdapterDateFns } from '@mui/x-date-pickers/AdapterDateFns';
import { DateField } from '@mui/x-date-pickers/DateField';
import { LocalizationProvider } from '@mui/x-date-pickers/LocalizationProvider';

const locales = { 'en-us': undefined, 'en-gb': enGB, 'zh-cn': zhCN, de };

export default function LocalizationDateFns() {
    const [locale, setLocale] = React.useState('en-us');

    return (
        <LocalizationProvider
            dateAdapter={AdapterDateFns}
            adapterLocale={locales[locale]}
        >
            <DateField defaultValue={new Date()} />
        </LocalizationProvider>
    );
}
