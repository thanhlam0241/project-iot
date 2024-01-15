/* eslint-disable  */

import { useState } from 'react';

import PropTypes from 'prop-types';

import Nav from './nav';
import Main from './main';
import Header from './header';

import Box from '@mui/material/Box';

import useAuth from 'src/hooks/Auth/auth';

// ----------------------------------------------------------------------

export default function DashboardLayout({ children }) {
  const [openNav, setOpenNav] = useState(false);

  const { auth, logout } = useAuth();

  return (
    <>
      <Header onOpenNav={() => setOpenNav(true)} />

      <Box
        sx={{
          minHeight: 1,
          display: 'flex',
          flexDirection: { xs: 'column', lg: 'row' },
        }}
      >
        <Nav openNav={openNav} onCloseNav={() => setOpenNav(false)} />

        <Main>{auth.username && children}</Main>
      </Box>
    </>
  );
}

DashboardLayout.propTypes = {
  children: PropTypes.node,
};
