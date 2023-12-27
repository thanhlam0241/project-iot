/* eslint-disable */
import { useCallback, useState } from 'react';
import {
    Box, Container, Stack, Typography, Button,
    Card,
    CardActions,
    CardContent,
    CardHeader,
    Divider,
    TextField
} from '@mui/material';

const SettingView = () => {
    const [values, setValues] = useState({
        password: '',
        confirm: ''
    });
    const handleChange = useCallback(
        (event) => {
            setValues((prevState) => ({
                ...prevState,
                [event.target.name]: event.target.value
            }));
        },
        []
    );

    const handleSubmit = useCallback(
        (event) => {
            event.preventDefault();
        },
        []
    );
    return (
        <Box
            component="main"
            sx={{
                flexGrow: 1,
                py: 8
            }}
        >
            <Container maxWidth="lg">
                <Stack spacing={3}>
                    <Typography variant="h4">
                        Cài đặt
                    </Typography>
                    <form onSubmit={handleSubmit}>
                        <Card>
                            <CardHeader
                                subheader="Update password"
                                title="Password"
                            />
                            <Divider />
                            <CardContent>
                                <Stack
                                    spacing={3}
                                    sx={{ maxWidth: 400 }}
                                >
                                    <TextField
                                        fullWidth
                                        label="Password"
                                        name="password"
                                        onChange={handleChange}
                                        type="password"
                                        value={values.password}
                                    />
                                    <TextField
                                        fullWidth
                                        label="Password (Confirm)"
                                        name="confirm"
                                        onChange={handleChange}
                                        type="password"
                                        value={values.confirm}
                                    />
                                </Stack>
                            </CardContent>
                            <Divider />
                            <CardActions sx={{ justifyContent: 'flex-end' }}>
                                <Button variant="contained">
                                    Update
                                </Button>
                            </CardActions>
                        </Card>
                    </form>
                </Stack>
            </Container>
        </Box>
    )
}

export default SettingView