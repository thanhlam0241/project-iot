import { Helmet } from 'react-helmet-async';

import { ProfileView } from 'src/sections/profile';

// ----------------------------------------------------------------------

export default function ProfilePage() {
    return (
        <>
            <Helmet>
                <title> Thông tin cá nhân  </title>
            </Helmet>

            <ProfileView />
        </>
    );
}
