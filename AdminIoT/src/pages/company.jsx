import { Helmet } from 'react-helmet-async';

import { CompanyView } from 'src/sections/company/view';

// ----------------------------------------------------------------------

export default function UserPage() {
    return (
        <>
            <Helmet>
                <title> Công ty/Doanh nghiệp  </title>
            </Helmet>

            <CompanyView />
        </>
    );
}
