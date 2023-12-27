import { Helmet } from 'react-helmet-async';

import { AttendanceView } from 'src/sections/attendance/view';

// ----------------------------------------------------------------------

export default function UserPage() {
    return (
        <>
            <Helmet>
                <title> Quản lý chấm công  </title>
            </Helmet>

            <AttendanceView />
        </>
    );
}
