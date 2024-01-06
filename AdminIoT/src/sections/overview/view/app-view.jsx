/* eslint-disable */
import { useState, useEffect, useMemo } from 'react';

import Container from '@mui/material/Container';
import Grid from '@mui/material/Unstable_Grid2';
import Typography from '@mui/material/Typography';

// import Iconify from 'src/components/iconify';

// import AppTasks from '../app-tasks';
// import AppNewsUpdate from '../app-news-update';
// import AppOrderTimeline from '../app-order-timeline';
import AppCurrentVisits from '../app-current-visits';
import AppWebsiteVisits from '../app-website-visits';
import AppWidgetSummary from '../app-widget-summary';
// import AppTrafficBySite from '../app-traffic-by-site';
// import AppCurrentSubject from '../app-current-subject';
// import AppConversionRates from '../app-conversion-rates';

import adminApi from 'src/api/adminApi';

// ----------------------------------------------------------------------

export default function AppView() {

  const [humanStatistic, setHumanStatistic] = useState({
    numberOfAccount: 0,
    numberOfAdminAccount: 0,
    numberOfDepartment: 0,
    numberOfEmployeeAccount: 0,
    numberOfMachine: 0,
    numberOfManagerAccount: 0
  });
  const [attendanceStatistic, setAttendanceStatistic] = useState({});
  const [isLoading, setIsLoading] = useState(false);
  const [year, setYear] = useState(2023 || new Date().getFullYear());

  const listOnTime = useMemo(() => {
    const list = attendanceStatistic.statisticInMonths || [];
    if (list.length === 0) {
      return Array(12).fill(0);
    }
    return list.map(item => item.numberOfOnTime || 0)
  }, [attendanceStatistic])

  const listLate = useMemo(() => {
    const list = attendanceStatistic.statisticInMonths || [];
    if (list.length === 0) {
      return Array(12).fill(0);
    }
    return list.map(item => item.numberOfLate || 0)
  }, [attendanceStatistic])

  const listAll = useMemo(() => {
    const list = attendanceStatistic.statisticInMonths || [];
    if (list.length === 0) {
      return Array(12).fill(0);
    }
    return list.map(item => item.numberOfAttendance || 0)
  }, [attendanceStatistic])

  const listMonth = useMemo(() => {
    const l = []
    for (let i = 0; i < 12; i++) {
      let monthFormat = i <= 9 ? `0${i + 1}` : `${i + 1}`
      l.push(`01/${monthFormat}/${year}`)
    }
    return l
  }, [year])

  // const listRateLate = useMemo(() => {
  //   const list = attendanceStatistic.statisticInMonths || [];
  //   console.log(list)
  //   if (list.length === 0) {
  //     return Array(12).map(() => ({
  //       label: `Tháng ${i + 1}`,
  //       value: 1
  //     }));
  //   }
  //   const result = list.map(item => ({
  //     label: `Tháng ${item.month}`,
  //     value: Math.ceil(item.percentOfLate) || 100
  //   }))
  //   console.log(result)
  //   return result
  // }, [attendanceStatistic])

  const getHumanStatistic = async () => {
    try {
      setIsLoading(true);
      const response = await adminApi.getHumanStatistic();
      if (response.data) {
        console.log(response.data);
        setHumanStatistic(response.data);
      }
    }
    catch (error) {
      console.log(error);
    }
    finally {
      setIsLoading(false);
    }
  }

  const getAttendanceStatistic = async () => {
    try {
      setIsLoading(true);
      const response = await adminApi.getAttendanceStatistic(year);
      if (response.data) {
        console.log(response.data);
        setAttendanceStatistic(response.data);
      }
    }
    catch (error) {
      console.log(error);
    }
    finally {
      setIsLoading(false);
    }
  }

  useEffect(() => {
    getHumanStatistic();
    getAttendanceStatistic();
  }, []);

  return (
    <Container maxWidth="xl">
      <Typography variant="h4" sx={{ mb: 5 }}>
        Hi, Welcome back 👋
      </Typography>

      <Grid container spacing={3}>
        <Grid xs={12} sm={6} md={3}>
          <AppWidgetSummary
            title="Nhân viên"
            total={humanStatistic.numberOfEmployeeAccount || 0}
            color="info"
            icon={<img alt="icon" src="/assets/icons/glass/ic_glass_users.png" />}
          />
        </Grid>
        <Grid xs={12} sm={6} md={3}>
          <AppWidgetSummary
            title="Đơn vị/Phòng ban"
            total={humanStatistic.numberOfDepartment || 0}
            color="success"
            icon={<img alt="icon" src="/assets/icons/glass/department.png" />}
          />
        </Grid>

        <Grid xs={12} sm={6} md={3}>
          <AppWidgetSummary
            title="Máy chấm công"
            total={humanStatistic.numberOfMachine || 0}
            color="warning"
            icon={<img alt="icon" src="/assets/icons/glass/machine.png" />}
          />
        </Grid>

        <Grid xs={12} sm={6} md={3}>
          <AppWidgetSummary
            title="Tài khoản"
            total={humanStatistic.numberOfAccount || 0}
            color="error"
            icon={<img alt="icon" src="/assets/icons/glass/account.png" />}
          />
        </Grid>

        <Grid xs={12} md={6} lg={8}>
          <AppWebsiteVisits
            title="Thống kê chấm công"
            subheader={`Năm ${year}`}
            chart={{
              labels: listMonth,
              series: [
                {
                  name: 'Số ca làm việc',
                  type: 'column',
                  fill: 'solid',
                  data: listAll,
                },
                {
                  name: 'Số ca đi muộn',
                  type: 'area',
                  fill: 'gradient',
                  data: listLate,
                },
                {
                  name: 'Số ca đúng giờ',
                  type: 'line',
                  fill: 'solid',
                  data: listOnTime,
                },
              ],
            }}
          />
        </Grid>

        <Grid xs={12} md={6} lg={4}>
          <AppCurrentVisits
            title="Thống kê người dùng"
            chart={{
              series: [
                { label: 'Admin', value: humanStatistic.numberOfAdminAccount || 0 },
                { label: 'Manager', value: humanStatistic.numberOfManagerAccount || 0 },
                { label: 'Employee', value: humanStatistic.numberOfEmployeeAccount || 0 }
              ],
            }}
          />
        </Grid>

        {/* <Grid xs={12} md={6} lg={8}>
          <AppConversionRates
            title="Tỷ lệ đi muộn"
            chart={{
              series: listRateLate,
            }}
          />
        </Grid> */}

        {/* <Grid xs={12} md={6} lg={4}>
          <AppCurrentSubject
            title="Current Subject"
            chart={{
              categories: ['English', 'History', 'Physics', 'Geography', 'Chinese', 'Math'],
              series: [
                { name: 'Series 1', data: [80, 50, 30, 40, 100, 20] },
                { name: 'Series 2', data: [20, 30, 40, 80, 20, 80] },
                { name: 'Series 3', data: [44, 76, 78, 13, 43, 10] },
              ],
            }}
          />
        </Grid> */}

        {/* <Grid xs={12} md={6} lg={8}>
          <AppNewsUpdate
            title="News Update"
            list={[...Array(5)].map((_, index) => ({
              id: faker.string.uuid(),
              title: faker.person.jobTitle(),
              description: faker.commerce.productDescription(),
              image: `/assets/images/covers/cover_${index + 1}.jpg`,
              postedAt: faker.date.recent(),
            }))}
          />
        </Grid>

        <Grid xs={12} md={6} lg={4}>
          <AppOrderTimeline
            title="Order Timeline"
            list={[...Array(5)].map((_, index) => ({
              id: faker.string.uuid(),
              title: [
                '1983, orders, $4220',
                '12 Invoices have been paid',
                'Order #37745 from September',
                'New order placed #XF-2356',
                'New order placed #XF-2346',
              ][index],
              type: `order${index + 1}`,
              time: faker.date.past(),
            }))}
          />
        </Grid> */}

        {/* <Grid xs={12} md={6} lg={4}>
          <AppTrafficBySite
            title="Traffic by Site"
            list={[
              {
                name: 'FaceBook',
                value: 323234,
                icon: <Iconify icon="eva:facebook-fill" color="#1877F2" width={32} />,
              },
              {
                name: 'Google',
                value: 341212,
                icon: <Iconify icon="eva:google-fill" color="#DF3E30" width={32} />,
              },
              {
                name: 'Linkedin',
                value: 411213,
                icon: <Iconify icon="eva:linkedin-fill" color="#006097" width={32} />,
              },
              {
                name: 'Twitter',
                value: 443232,
                icon: <Iconify icon="eva:twitter-fill" color="#1C9CEA" width={32} />,
              },
            ]}
          />
        </Grid>

        <Grid xs={12} md={6} lg={8}>
          <AppTasks
            title="Tasks"
            list={[
              { id: '1', name: 'Create FireStone Logo' },
              { id: '2', name: 'Add SCSS and JS files if required' },
              { id: '3', name: 'Stakeholder Meeting' },
              { id: '4', name: 'Scoping & Estimations' },
              { id: '5', name: 'Sprint Showcase' },
            ]}
          />
        </Grid> */}
      </Grid>
    </Container>
  );
}
