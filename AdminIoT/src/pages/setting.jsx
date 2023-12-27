import { Helmet } from 'react-helmet-async';

import { SettingView } from 'src/sections/setting';

// ----------------------------------------------------------------------

export default function UserPage() {
    return (
        <>
            <Helmet>
                <title> Cài đặt  </title>
            </Helmet>

            <SettingView />
        </>
    );
}
