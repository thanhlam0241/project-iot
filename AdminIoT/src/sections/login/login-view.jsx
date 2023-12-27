import { useState } from 'react';

import Box from '@mui/material/Box';
import Link from '@mui/material/Link';
import Card from '@mui/material/Card';
import Stack from '@mui/material/Stack';
// import Button from '@mui/material/Button';
// import Divider from '@mui/material/Divider';
import TextField from '@mui/material/TextField';
import Typography from '@mui/material/Typography';
import IconButton from '@mui/material/IconButton';
import LoadingButton from '@mui/lab/LoadingButton';
import { alpha, useTheme } from '@mui/material/styles';
import InputAdornment from '@mui/material/InputAdornment';

import { useRouter } from 'src/routes/hooks';

import useAuth from 'src/hooks/Auth/auth';

import { bgGradient } from 'src/theme/css';

import Logo from 'src/components/logo';
import Iconify from 'src/components/iconify';
import { Backdrop } from 'src/components/backdrop';

// ----------------------------------------------------------------------

export default function LoginView() {
  const theme = useTheme();

  const [loading, setLoading] = useState(false);

  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [errorUsername, setErrorUsername] = useState(false);
  const [errorPassword, setErrorPassword] = useState(false);

  const [errorText, setErrorText] = useState('');

  const { login } = useAuth();

  const router = useRouter();

  const [showPassword, setShowPassword] = useState(false);

  const handleClick = () => {
    let isValid = true;
    if (!username && password) {
      setErrorUsername(true);
      setErrorText('Tên đăng nhập không được để trống');
      isValid = false;
    }
    else if (!password && username) {
      setErrorPassword(true);
      isValid = false;
    }
    else if (!username && !password) {
      setErrorUsername(true);
      setErrorPassword(true);
      setErrorText('Tên đăng nhập/mật khẩu không được để trống');
      isValid = false;
    }
    if (!isValid) {
      return;
    }
    setLoading(true);
    setTimeout(() => {
      login()
      setLoading(false);
      router.push('/');
    }, 2000);
  };

  const onChangeUsername = (e) => {
    setUsername(e.target.value);
    setErrorUsername(false);
    setErrorText('');
  }

  const onChangePassword = (e) => {
    setPassword(e.target.value);
    setErrorPassword(false);
    setErrorText('');
  }


  const renderForm = (
    <>
      <Stack spacing={3}>
        <Typography variant="body2" sx={{ color: errorText ? 'red' : 'transparent' }}>
          {errorText || 'Nothing'}
        </Typography>
        <TextField
          name="email"
          label="Tên đăng nhập"
          value={username}
          error={errorUsername}
          onChange={onChangeUsername}
        />

        <TextField
          name="password"
          label="Mật khẩu"
          type={showPassword ? 'text' : 'password'}
          value={password}
          error={errorPassword}
          onChange={onChangePassword}
          InputProps={{
            endAdornment: (
              <InputAdornment position="end">
                <IconButton onClick={() => setShowPassword(!showPassword)} edge="end">
                  <Iconify icon={showPassword ? 'eva:eye-fill' : 'eva:eye-off-fill'} />
                </IconButton>
              </InputAdornment>
            ),
          }}
        />
      </Stack>

      <Stack direction="row" alignItems="center" justifyContent="flex-end" sx={{ my: 3 }}>
        <Link variant="subtitle2" underline="hover">
          Quên mật khẩu?
        </Link>
      </Stack>

      <LoadingButton
        fullWidth
        size="large"
        type="submit"
        variant="contained"
        color="inherit"
        onClick={handleClick}
      >
        Login
      </LoadingButton>
    </>
  );

  return (
    <Box
      sx={{
        ...bgGradient({
          color: alpha(theme.palette.background.default, 0.1),
          imgUrl: '/assets/background/overlay_4.jpg',
        }),
        height: 1,
      }}
    >
      <Backdrop open={loading} />
      <Logo
        sx={{
          position: 'fixed',
          top: { xs: 16, md: 24 },
          left: { xs: 16, md: 24 },
        }}
      />

      <Stack alignItems="center" justifyContent="center" sx={{ height: 1 }}>
        <Card
          sx={{
            p: 5,
            width: 1,
            maxWidth: 420,
          }}
        >
          <Typography variant="h4">Đăng nhập</Typography>

          {/* <Stack direction="row" spacing={2}>
            <Button
              fullWidth
              size="large"
              color="inherit"
              variant="outlined"
              sx={{ borderColor: alpha(theme.palette.grey[500], 0.16) }}
            >
              <Iconify icon="eva:google-fill" color="#DF3E30" />
            </Button>

            <Button
              fullWidth
              size="large"
              color="inherit"
              variant="outlined"
              sx={{ borderColor: alpha(theme.palette.grey[500], 0.16) }}
            >
              <Iconify icon="eva:facebook-fill" color="#1877F2" />
            </Button>

            <Button
              fullWidth
              size="large"
              color="inherit"
              variant="outlined"
              sx={{ borderColor: alpha(theme.palette.grey[500], 0.16) }}
            >
              <Iconify icon="eva:twitter-fill" color="#1C9CEA" />
            </Button>
          </Stack>

          <Divider sx={{ my: 3 }}>
            <Typography variant="body2" sx={{ color: 'text.secondary' }}>
              OR
            </Typography>
          </Divider> */}

          {renderForm}
        </Card>
      </Stack>
    </Box>
  );
}
